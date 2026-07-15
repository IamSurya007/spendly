enum ConflictResolution {
  useLocal,
  useRemote,
  conflict,
  delete,
}

class ResolutionResult {
  final ConflictResolution action;
  final Map<String, dynamic>? mergedPayload;

  ResolutionResult(this.action, [this.mergedPayload]);
}

class ConflictResolver {
  static ResolutionResult resolve({
    required String entityType,
    required bool localIsDirty,
    required int localVersion,
    required DateTime localUpdatedAt,
    required bool localIsDeleted,
    required int remoteVersion,
    required DateTime remoteUpdatedAt,
    required bool remoteIsDeleted,
    required Map<String, dynamic> localPayload,
    required Map<String, dynamic> remotePayload,
  }) {
    // 1. Deletes always win over concurrent edits
    if (localIsDeleted || remoteIsDeleted) {
      return ResolutionResult(ConflictResolution.delete);
    }

    // 2. If local is not dirty, remote simply wins if its version or timestamp is newer
    if (!localIsDirty) {
      if (remoteVersion > localVersion || remoteUpdatedAt.isAfter(localUpdatedAt)) {
        return ResolutionResult(ConflictResolution.useRemote);
      }
      return ResolutionResult(ConflictResolution.useLocal);
    }

    // 3. If local is dirty, check if the server has a newer version that conflicts
    // If the server version is less than or equal to the client's version, the local change is newer
    if (remoteVersion <= localVersion) {
      return ResolutionResult(ConflictResolution.useLocal);
    }

    // 4. Version conflict! Both have updated concurrently since the last sync.
    // Financial safety check: Divergent loan statuses (e.g. local 'PAID' vs remote 'OVERDUE')
    if (entityType == 'loan') {
      final localStatus = localPayload['status']?.toString().toUpperCase();
      final remoteStatus = remotePayload['status']?.toString().toUpperCase();
      if (localStatus != remoteStatus) {
        return ResolutionResult(ConflictResolution.conflict);
      }
    }

    // 5. Default: Last-Write-Wins by timestamp
    if (remoteUpdatedAt.isAfter(localUpdatedAt)) {
      return ResolutionResult(ConflictResolution.useRemote);
    } else {
      return ResolutionResult(ConflictResolution.useLocal);
    }
  }
}
